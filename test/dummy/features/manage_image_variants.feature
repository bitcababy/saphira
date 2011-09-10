Feature: Manage image variants
  In order to show images on the page
  a user
  wants to resize and crop images
  
  Scenario: create a new named image variant
    Given I am on "/admin/saphira/files"
    And I follow "image variants" within ".menu"
    And I follow "New Image variant"
    When I fill in "image_variant_name" with "square"
    And I fill in "image_variant_manipulation" with "300x 300x300+0+0"
    And I press "Create Image variant"
    Then I should see "square" within "h1"
  
  Scenario: setup image for variant square
    Given the image_variant "square" exists
    And the image "eos-550d-wrong-orientation.jpg" is uploaded
    When I am on "/admin/saphira/files"
    And I follow "eos-550d-wrong-orientation.jpg"
    And I follow "show" within ".square"
    And I follow "Edit"
    And I fill in "file_item_field_pre_manipulation_1" with "300x300#"
    And I press "update"
    Then I should see an image as square within "#saphira-file-preview"