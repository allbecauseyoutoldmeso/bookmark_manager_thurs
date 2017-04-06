require 'bcrypt'

class User

  include DataMapper::Resource
  has n, :links, through: Resource

  property :id, Serial
  property :email, String # , required: true #this tells the database not to accept users sans emails
  property :password_digest, Text
  attr_reader :password
  attr_accessor :confirm_password



  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end



  # default would be password_confirmation, unless changed like below
  validates_confirmation_of :password, :confirm => :confirm_password,
    :message => "Doh.  Your passwords don't match."
  validates_presence_of :email,
    :message => "Really?  Dude!  Please enter an email address in the email field."
  # ...this prevents creation of user without email, but is unnecessary if use 'required: true' next to property :email aboveove
  validates_format_of :email, as: :email_address,
    :message =>  "Please enter a valid email address."
  #or next to property :email can put format: :email_address
  validates_uniqueness_of :email,
    :message => "Doh.  This email address is already registered."

  #or next to email unique: true
end
