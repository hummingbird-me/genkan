# frozen_string_literal: true

module Types
  class ScopeEnum < BaseEnum
    value 'FOLLOWS_WRITE', 'Follow other users and join groups'
    value 'LIBRARY_PRIVATE', 'View all library entries (including private ones)'
    value 'LIBRARY_WRITE', "Update the user's library"
    value 'PROFILE_READ', "View the user's public profile data"
    value 'PROFILE_WRITE', "Edit the user's profile data"
    value 'PROFILE_EMAIL', "View the user's email address"
    value 'POSTS_WRITE', 'Make posts on behalf of the user'
    value 'POSTS_READ', "Read the user's feed data"
    value 'GROUPS_WRITE', 'Administer groups for the user'
    value 'SETTINGS_WRITE', "Edit the user's settings"
    value '_ALL', 'Do anything'
  end
end
