class InsightlyService::InsightlyCreator < BaseService
  attr_accessor :user
  inject :insightly_repository

  def initialize(user)
    self.user = user
    @insightly = Insightly2.client
  end

  def perform
    InsightlyService::UserContact.new(@user).perform
    InsightlyService::UserOrganization.new(@user).perform
    InsightlyService::UserOpportunity.new(@user).perform
    InsightlyService::UserTask.new(@user).perform
  end

  def contact_infos
    [{ type: "Email", label: "Work", detail: @user.email },
     { type: "Phone", label: "Work", detail: @user.business.phone
     }
    ]
  end

  def find_insightly_type_id(type)
    insightly_repository.find_user_insightly(@user, type).try(:type_id)
  end

  def insightly_hash(name, type, id, user_id = nil)
    {
      name: name,
      insightly_type: type,
      type_id: id,
      user_id: user_id
    }
  end

  def inslightly_create(type, id, user_id = nil, name = nil)
    insightly_repository.find_or_create(insightly_type: type,
                                        type_id: id, name: name,
                                        user_id: user_id)
  end
end
