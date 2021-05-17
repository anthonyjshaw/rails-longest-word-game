require "application_system_test_case"

class GamesTest < ApplicationSystemTestCase
   test "Going to /new gives us a new random grid to play with" do
      visit new_url
      assert test: "New game"
      assert_selector "li", count: 10
    end

    test "Entering a random word gives back a message that the word is not in the grid" do
      visit new_url
      fill_in 'word', with: 'dave'
      click_on 'Play'
      assert_text "can't be built out of"
    end

    def sample
      @newsample = params[:word_grid]
      puts @newsample
    end

    test 'Entering a word made up letters from the grid, but is not an English word' do
      visit new_url
      fill_in 'word', with: sample
      raise
      click_on 'Play'
      assert_text 'is not a word! Try again!'
    end
end
