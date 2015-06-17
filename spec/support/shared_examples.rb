shared_examples_for "redirects to signin if user not logged in" do
  context "user is not logged in" do
    it "redirects to login page" do
      expect(response).to redirect_to(new_user_session_path)
    end
  end
end
