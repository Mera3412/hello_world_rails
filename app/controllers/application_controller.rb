class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session # なぜUser_Countrollerにも継承されるか→継承元になっているから
end
