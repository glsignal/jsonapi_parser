require 'json/api'

describe JSON::API, '#parse' do
  it 'succeeds when there are no duplicates' do
    payload = {
      'data' => [
        {
          'type' => 'articles',
          'id' => '1',
          'attributes' => {
            'title' => 'JSON API paints my bikeshed!'
          },
          'links' => {
            'self' => 'http://example.com/articles/1'
          },
          'relationships' => {
            'author' => {
              'links' => {
                'self' => 'http://example.com/articles/1/relationships/author',
                'related' => 'http://example.com/articles/1/author'
              },
              'data' => { 'type' => 'people', 'id' => '9' }
            },
            'journal' => {
              'data' => nil
            },
            'comments' => {
              'links' => {
                'self' => 'http://example.com/articles/1/relationships/comments',
                'related' => 'http://example.com/articles/1/comments'
              },
              'data' => [
                { 'type' => 'comments', 'id' => '5' },
                { 'type' => 'comments', 'id' => '12' }
              ]
            }
          }
        }]
    }

    JSON::API.parse(payload, verify_duplicates: true)
  end

  it 'fails when there are duplicates within primary data' do
    payload = {
      'data' => [
        {
          'type' => 'articles',
          'id' => '1'
        }, {
          'type' => 'articles',
          'id' => '1'
        }]
    }

    expect { JSON::API.parse(payload, verify_duplicates: true) }
      .to raise_error(JSON::API::InvalidDocument)
  end

  it 'fails when there are duplicates within included' do
    payload = {
      'data' => nil,
      'included' => [
        {
          'type' => 'articles',
          'id' => '1'
        }, {
          'type' => 'articles',
          'id' => '1'
        }]
    }

    expect { JSON::API.parse(payload, verify_duplicates: true) }
      .to raise_error(JSON::API::InvalidDocument)
  end

  it 'fails when there are duplicates within primary data' do
    payload = {
      'data' => [
        {
          'type' => 'articles',
          'id' => '1'
        }
      ],
      'included' => [
        {
          'type' => 'articles',
          'id' => '1'
        }]
    }

    expect { JSON::API.parse(payload, verify_duplicates: true) }
      .to raise_error(JSON::API::InvalidDocument)
  end
end
