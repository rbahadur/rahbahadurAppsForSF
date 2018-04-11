global class ProjectCalloutServiceMockFailure  implements HttpCalloutMock {
     global HTTPResponse respond(HTTPRequest req) { 
        HttpResponse response = new HttpResponse();
        response.setStatusCode(400);
        response.setStatus('Error Occured');
        return response; 
  }
}