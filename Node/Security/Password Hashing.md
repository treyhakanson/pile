# Password Hashing Using a Salt
A salt is a random set of characters, and is used in unison with a user entered password and then hashed before being stored in the database.

## Creating and Storing the Password
1. Get the user's password
2. Generate a salt (a random string of characters)
3. Combine the salt and user generated password
4. Hash the combined string with a suitable cryptographic algorithm
5. Store the result as the password, and also store the salt

## Validating User Password
1. Validate the username and fetch the hashed result and salt from the database
2. Combine the user entered password with the salt stored for that user
3. Hash the combined string with the same cryptographic algorithm used originally
4. compare the result with the stored hash

## Using crypto to Salt and Hash Passwords
'crypto' is a built-in node module that makes the hashing process simple:

```javascript
const crypto = require('crypto');
/**
  generates random string of characters i.e salt
  @function
  @param {number} length - Length of the random string.
*/
function genRandomString(length){
    return crypto.randomBytes(Math.ceil(length/2))
            .toString('hex')		/** convert to hexadecimal format */
            .slice(0, length);	/** return required number of characters */
};

/**
 * hash password with sha512.
 * @function
 * @param {string} password - List of required fields.
 * @param {string} salt - Data to be validated.
 */
function sha512(password, salt){
    var hash = crypto.createHmac('sha512', salt); /** Hashing algorithm sha512 */
    hash.update(password);
    var value = hash.digest('hex');
    return {
        salt: salt,
        passwordHash: value
    };
};

function saltHashPassword(userpassword) {
    var salt = genRandomString(16); /** Gives us salt of length 16 */
    var passwordData = sha512(userpassword, salt);
    console.log('UserPassword =', userpassword);
    console.log('Passwordhash =', passwordData.passwordHash);
    console.log('\nSalt =', passwordData.salt);
}
```

