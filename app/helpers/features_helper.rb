module FeaturesHelper
  def user_story_tip
    "
    User story is a description of functionality that will be valuable <br/>
    to user or customer of the product. <br/>
    A good template for user story: <br/>
      &nbsp;<em>As a [user_role_of_the_product]<br/>
      &nbsp;I can [do_action_with_the_product]</em>
    "
  end

  def acceptance_test_tip
    "
    Acceptance test is a set of criterias that will be used to determine <br/>
    whether a story is fully implemented. <br/>
    <u>Note</u>: Separate multiple acceptance test with dash. <br/>
    e.g: <br/>
    - Test with malicious data <br/>
    - Test with multiple concurrent users
    "
  end

  def story_points_tip
    "
    Story points are a unit of measure for expressing the overall size of a user story. <br/>
    This can be filled in at later stage after the team has determined the ideal <br/>
    story points for this feature. <br/>
    <u>Tip</u>: Fibonacci sequence is what mostly used to define story points 
    "
  end

  def business_value_tip
    "
    Business value is a financial measure of the amount of money that<br/> will be made or saved 
    if this feature is implemented.
    "
  end

  def priority_tip
    "
    Priority is the level of priority to implement this feature.
    "
  end
end