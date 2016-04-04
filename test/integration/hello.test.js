var assert = require('assert');
var http = require('http');

describe('Api',  () => {
  describe('/', () => {
    it('should return hello world', (done) => {
      http.get('http://localhost:8000/', (response) => {
        assert.equal(response.statusCode, 200);
        var data = '';
        response.on('data', (chunk) => {
          data += chunk;
        });
        response.on('end', () => {
          assert.equal(data, 'Hello world');
          done();
        })
      });
    });
  });
});