describe "do_nothing" do 
  
  policy :test
  severity 3

  def run 
    true
  end
end
