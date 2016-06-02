class TextsController < ApplicationController
    
    def mission
        @mission_text = Text.find_by_title("Our Mission")
    end 
    
    def background
        @background_text = Text.find_by_title("Background")
    end 
    
end
  
