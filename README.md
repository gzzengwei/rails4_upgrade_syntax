# Rails4 Upgrade Syntax
##  
update code syntax for rails 4

## Current Progress

    find_by
    find_or_initialize_by
    find_or_create_by
    
## Example

    client.users.find_by_user_id_and_organisation_id(current_user.id, current_user.organisation.id).update(:enabled, true)
    #=>
    client.users.find_by(user_id: current_user.id, organisation_id: current_user.organisation.id).update(:enabled, true)
    
    
## Usage
    rails4_upgrade_syntax.rb <target folder or file>
    
Or    
    
    ruby rails4_upgrade_syntax.rb <target folder or file>
    
## Notes
1. Processed by lines
2. accepting parentheses inside find_xP_by()
  
