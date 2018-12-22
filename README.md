# Genkan (玄関)

Genkan is the Kitsu Authentication service, written as a standalone application in Rails 5, backed
by PostgreSQL.  In terms of functionality, it sits somewhere between Devise and Doorkeeper, but
implemented as an application instead of a gem.  Because it's implemented as a full Rails app, you
don't need to worry about dependency conflicts or naming collisions or any of that nonsense.

Simply fork Genkan, change the views, hook your own application up to the API, and you're set.  To
update, just rebase.

## Models

### User Name

The `UserName` model maps case-insensitive user-friendly identifiers such as email addresses or
account names to a computer-provided User ID.  The User ID is completely opaque to Genkan, and
it's up to you what string you wanna use.  Kitsu uses auto-incrementing integers, but you don't have
to.  If you use UUIDs for users, that works too.

### User Password

A user can have as many passwords as you want.  The passwords are bcrypt-hashed before storage,
marked with a creation time, and you can mark them as invalid at any time.

### User Assertion ID

The OAuth2 Assertion Grant provides a flow for authorization where a client presents a valid token
from an external service (such as Twitter, Facebook, or Google) which can be verified by the server.
For this purpose, Genkan has a `UserAssertionID` model, which stores a mapping between an external
user ID and an internal user ID.

### Token

Genkan issues signed JWTs for all Tokens (using RS256 by default) but also stores their metadata in
a database table for revocation.  For revocation to work, your application must use the API to
authenticate the token on each request.
