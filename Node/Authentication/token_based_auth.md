# Token Based Authentication
Token based authentication is very promominent when needing to authenticate a multitude of users

## Main Reasons for Using Token Based Authentication over Server Based Authetication
* Stateless and scalable servers
* Mobile application ready
* Pass authentication to other applications
* Added security

Authentication traditionally was done using primarily server based authentication. Since the HTTP protocol is stateless, if a user is authenticated by username and password, then on the next request, our application won't know who the user is and they'll need to be authenticated again. 

In summary, server based authetication works as follows:
1. server delivers website
2. user logs in with username and password, server saves user info in a session
3. every request to the server checks the session, and if everything checks out, the data is sent back

Some major problems arose with this method of authentication
1. *Sessions* Everytime a user is autheticated, the server needs to create a new session. This is typically done in memory, and with a large amount of users this can become an issue.
2. *Scalability* Sessions are stored in memory, which means that as cloud providers start to replicate instances to handle application load, having vital session information stored in memory will limit the ability to scale.
3. *CORS* As more devices (namely mobile) are attempting to access the api, CORS (Cross-Origin Resource Sharing) becomes and issue since the device is not on the same IP as the api.
4. *CSRF* Protection against cross site request forgery also comes into the fold. Users are susceptible to CSRF attacks since they can already be authenticated with say a banking site and this could be taken advantage of when visiting other sites.

To summarize scalability issues, session based authentication requires the user to connect to the same server they logged into, because that server has the disk where the their session infomation was written to. Tokens are stateless, so any server can handle a token regardless of what server distributed it.

## How Token Based Authetication Works
Token based authetication is stateless since it does not require a session to be stored. This alone takes care of most of the issues arising from server based authetication

Token based authetication boils down to:
1. User logs in with username, password
2. Application validates credentials
3. Application provides a signed token to the client
4. Client stores that token and sends it with every request
5. Server verifies token and responds with data

Every request requires the token which will be sent in the HTTP header so that the requests remain stateless. Now the server can safely be set to take requests from anywhere using `Access-Control-Allow-Origin: *`. Note that setting the ACAO header to * does not allow requests to supply credentials like HTTP authentication, client-side SSL certificates, or cookies.

These tokens can even be passed around to third party applications like mobile apps, allowing them to access the data. Tokens can even vary based on what types of information the are allowed to retrieve. For example, and admin token may be able to get all data whereas a third-party token may only be able to get very specific user information

## Benefits of Tokens
### Security
No cookies are involved with tokens, which helps prevent CSRF attacks. Even if the token is stored in a cookie on the client side, this is merely a storage mechanism and not an authetication method so CSRF attacks are still mitigated. Tokens also expire after a set amount of time, requiring the user to log back in every once and a while. Tokens and groups of tokens can also be [revoked](https://tools.ietf.org/html/rfc7009) if needed, immediately invalidating them.

### Extensibility (Friend of a Friend and Permissions)
Tokens allow applications to provide specific permissions depending on client/platform attempting to be autheticated by the service.

### Multiple Platforms and Domains
Tokens let us set the ACAO to *, meaning that any origin can request data from the server. The application just needs a valid token to get data. (CORS is needed when using session based auth to prevent attacks such as CSRF attacls)

### Standards Based
There are [standards](https://scotch.io/tutorials/the-anatomy-of-a-json-web-token) to creating JSON web tokens, which have a very broad range of support over across languages and platforms.

