class TextsController < ApplicationController
    
    def mission
        @text = Text.find_by_title("Our Mission")
    end 
    
end
  
