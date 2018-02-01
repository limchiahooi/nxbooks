describe "the signin process", :type => :feature do
  before :each do
    User.create(name: "myname", password: "test_password", email: "user1@example.com")
  end

  it "signs me in" do
    visit '/sign_in'
    within("#sign-in") do      
      fill_in 'Email', with: 'user1@example.com'
      fill_in 'Password', with: 'test_password'
    end
    click_button 'Sign in'
    expect(page).to have_content 'You have successfully signed in!'
  end

end