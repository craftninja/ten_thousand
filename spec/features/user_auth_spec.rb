require 'spec_helper'

feature 'User login' do

  scenario 'User is welcomed on homepage' do
    visit '/'
    expect(page).to have_content('Welcome to the Game of TenThousand')
  end

  scenario 'User can register' do
    visit '/'
    click_link 'Register'
    fill_in 'Username', :with => 'Albert'
    fill_in 'Email', :with => 'albert@example.com'
    fill_in 'Password', :with => 'thebighouse'
    fill_in 'Password confirmation', :with => 'thebighouse'
    click_button 'Register'
    expect(page).to have_content('Albert, welcome to your Game of TenThousand')
    expect(page).to_not have_content('Register')
    expect(page).to have_content('Log out')
  end

  scenario 'User can log out' do
    visit '/'
    click_link 'Register'
    fill_in 'Username', :with => 'Albert'
    fill_in 'Email', :with => 'albert@example.com'
    fill_in 'Password', :with => 'thebighouse'
    fill_in 'Password confirmation', :with => 'thebighouse'
    click_button 'Register'
    click_link 'Log out'
    expect(page).to_not have_content('Albert, welcome to your Game of TenThousand')
    expect(page).to have_content('Register')
  end

  scenario 'User can log in' do
    email = 'albert@example.com'
    password = 'thebighouse'
    visit '/'
    click_link 'Register'
    fill_in 'Username', :with => 'Albert'
    fill_in 'Email', :with => email
    fill_in 'Password', :with => password
    fill_in 'Password confirmation', :with => password
    click_button 'Register'
    click_link 'Log out'
    click_link 'Log in'
    fill_in 'Email', :with => email
    fill_in 'Password', :with => password
    click_button 'Log in'
    expect(page).to have_content('Albert, welcome to your Game of TenThousand')
    expect(page).to_not have_content('Welcome to the Game of TenThousand')
  end

  scenario 'User cannot login with unregistered email' do
    visit '/'
    click_link 'Log in'
    fill_in 'Email', :with => 'albert@example.com'
    fill_in 'Password', :with => 'thebighouse'
    click_button 'Log in'
    expect(page).to have_content('Email and/or Password is invalid')
  end

  scenario 'User cannot login with incorrect password' do
    email = 'albert@example.com'
    visit '/'
    click_link 'Register'
    fill_in 'Username', :with => 'Albert'
    fill_in 'Email', :with => email
    fill_in 'Password', :with => 'thebighouse'
    fill_in 'Password confirmation', :with => 'thebighouse'
    click_button 'Register'
    click_link 'Log out'
    click_link 'Log in'
    fill_in 'Email', :with => email
    fill_in 'Password', :with => 'password'
    click_button 'Log in'
    expect(page).to have_content('Email and/or Password is invalid')
  end

  scenario 'User cannot login with already registered email address' do
    email = 'albert@example.com'
    visit '/'
    click_link 'Register'
    fill_in 'Username', :with => 'Albert'
    fill_in 'Email', :with => email
    fill_in 'Password', :with => 'thebighouse'
    fill_in 'Password confirmation', :with => 'thebighouse'
    click_button 'Register'
    click_link 'Log out'
    click_link 'Register'
    fill_in 'Username', :with => 'Alberto'
    fill_in 'Email', :with => email
    fill_in 'Password', :with => 'password'
    fill_in 'Password confirmation', :with => 'password'
    click_button 'Register'
    expect(page).to have_content('Are you having deja vu? We are. Did you forget your password?')
  end

  scenario 'User must enter matching password and password confirmation' do
    visit '/'
    click_link 'Register'
    fill_in 'Username', :with => 'Albert'
    fill_in 'Email', :with => 'albert@example.com'
    fill_in 'Password', :with => 'thebighouse'
    fill_in 'Password confirmation', :with => 'not the big house'
    click_button 'Register'
    expect(page).to have_content('Oops, your password and password confirmation don\'t match')
  end

end
