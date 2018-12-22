# frozen_string_literal: true

module Types
  class ScopeEnum < BaseEnum
    value 'FOLLOWS.WRITE', 'Follow other users'
    value 'GROUP_MEMBERS.WRITE', 'Join groups'
    value 'LIBRARY_ENTRIES.PRIVATE', 'View all library entries (including private ones)'
    value 'LIBRARY_ENTRIES.WRITE', "Update the user's library"
    value 'PROFILE.READ', "View the user's public profile data"
    value 'PROFILE.WRITE', "Edit the user's profile data"
    value 'PROFILE.EMAIL', "View the user's email address"
    value 'POSTS.WRITE', 'Make posts on behalf of the user'
    value 'POSTS.READ', "Read the user's feed data"
    value 'GROUPS.WRITE', 'Administer groups for the user'
    value 'SETTINGS.WRITE', "Edit the user's settings"
    value '_ALL', 'Do anything'
  end
end
