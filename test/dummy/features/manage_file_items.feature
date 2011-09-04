Feature: Manage file_items
  In order to show images on the page
  a user
  wants to upload images and manage them in folders
  
  Scenario: Create new folder
    Given I am on "/admin/saphira/files"
    And I follow "New Folder"
    When I fill in "file_item_name" with "My first folder"
    And I press "Create"
    Then I should be on "/admin/saphira/files/my-first-folder"
    And I should see "My first folder" within "h1"

  Scenario: Delete folder
    Given the following file_items:
      | name             | item_type |
      | My first folder  | folder    |
      | My second folder | folder    |
    And I am on "/admin/saphira/files"
    When I follow "saphira-action-destroy-my-first-folder"
    Then I should see "My second folder"
    And I should not see "My first folder"

  Scenario: Upload an image
    Given I am on "/admin/saphira/files"
    And I follow "New File"
    When I fill in "file_item_name" with "My first image"
    And I attach the file "eos-550d-wrong-orientation.jpg"
    When I fill in "file_item_tag_list" with "Trash, Orange, Berlin"
    And I press "Create"
    Then I should be on "/admin/saphira/files/my-first-image"
    And I should see "My first image" within ".information"
    And I should see "Trash, Orange, Berlin" within ".information"
    And I should see "Canon EOS 550D" within ".information"
    And I should see "Field Image Orientation Transformed" within ".information"