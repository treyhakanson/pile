# JSON Web Tokens
JSON Web Tokens (JWTs) are critical for modern APIs not only for security, but for interporability. Tokens allows for intermingling with 3rd-party applications, accessibility to developers, and restrcition of permissions on a per-client basis.

## Overview
Some quick points on JWTs:
* Work in many different platforms and environments with a variety of languages
* JWTs are self contained, meaning that they carry all the information required within themselves; a JWT will be able to transmit basic information about itself, a payload (usually user information), and a signature.
* Since they're self contained, its very easy to pass them around through request headers, urls, etc.

## Anatomy
JWTs have 3 parts, separated by a `.`:
`aaaaaaaaaa.bbbbbbbbbbb.cccccccccccc`

### Part 1: Header
The header consists of two parts, the type and the hashing algorithm. The type will be JWT, and the hashing algorithm will vary based on needs and preference. Here is an example (This will be base 64 encoded in the token):

``` json
{
	"typ": "JWT",
	"alg": "HS256"
}
```

### Part 2: Payload
The payload (also called JWT Claims) will carry the bulk of the of the JWT; this is where information detailing what we want to transfer and other information about the token itself. Each token can provide multiple claims in the payload.

#### Registered Claims
These are claims whose names are reserved, but are not mandatory.
* `iss` the issuer of the token
* `sub` the subject of the token
* `aud` the audience of the token
* `exp` when the token expires (almost always used)
* `nbf` the time before which the token must not be accepted for processing
* `iat` the issuing time of the token
* `jti` unique identifier for the token

#### Public Claims
These are claims that are created internally, things such as user name, information, etc.

#### Private Claims
A producer and consumer may agree to use claim names that are private. These are subject to collision, so use them with caution. (AKA they aren't registered; they're essentially just organized public claims agreed upon by outside parties, so setting up your own public claim with the same name would cause a collision)

#### Example Payload
the following example has two registered claims (iss, exp) and two public (name, admin) claims (this would also be base 64 encoded when actually inserted into the token)
```json
{
	"iss": "hatchli.io",
	"exp": 1300819380,
	"name": "Trey Hakanson",
	"admin": true
}
```

### Part 3: Signature
The signature is made up of a hash of the header, the payload, and "the secret". The secret is the signature held by the server, an allows the server to verify existing tokens and sign new ones. The signature will be hashed using the algoirthm specified in the header.

[auth0](https://auth0.com/) will handle a lot of this (all of it actually) for you, but not sure if it's any good. Seems bad to try to implement these tokens myself though.