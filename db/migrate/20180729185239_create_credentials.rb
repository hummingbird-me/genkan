class CreateCredentials < ActiveRecord::Migration[5.2]
  # These tables provide the login information for a user, all tied to User ID.  We don't use a User
  # table, since we don't store any actual information about a User in this application, only their
  # denormalized credentials information.
  def change
    # This table holds email and other "keys" for logging in with a password.  Status represents
    # whether the name is valid or not for login, though invalid names should generally be deleted,
    # and this flag should be used sparingly.  Kind says whether it's an email, a name, or something
    # else.
    create_table :user_names do |t|
      t.integer :user_id, null: false
      t.string :name, null: false
      t.integer :status, null: false, default: 1
      t.integer :kind, null: false

      t.timestamps
    end
    add_index :user_names, :name, unique: true
    # This table holds passwords for logging in with a name.  These are currently bcrypted, but this
    # may change someday.  Passwords have a source saying where we got them (currently Aozora or
    # Kitsu) and a status (whether the password is acceptable or blocked or whatever).  Generally,
    # a password should be deleted after it's no longer in use.  Use status sparingly.
    create_table :user_passwords do |t|
      t.integer :user_id, null: false
      t.string :password, null: false
      # Default is Kitsu-sourced password
      t.integer :source, null: false, default: 0
      # Default is Live
      t.integer :status, null: false, default: 1

      t.timestamps
    end
    # This table holds assertion IDs for Facebook/Twitter login.  These IDs are stored as opaque
    # strings, because we never know what a site is gonna give us.
    create_table :user_assertion_ids do |t|
      t.integer :user_id, null: false
      t.string :assertion, null: false
      t.integer :source, null: false

      t.timestamps
    end
    add_index :user_assertion_ids, %i[source assertion], unique: true
  end
end
