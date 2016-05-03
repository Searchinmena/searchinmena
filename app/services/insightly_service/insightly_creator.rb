class InsightlyService::InsightlyCreator < BaseService
  attr_accessor :user
  inject :insightly_repository

  def initialize(user)
    self.user = user
    @insightly = Insightly2.client
  end

  def perform
    InsightlyService::UserContact.new(user).perform
    InsightlyService::UserOrganization.new(user).perform
    InsightlyService::UserOpportunity.new(user).perform
    InsightlyService::UserTask.new(user).perform
  rescue => e
    puts "insightly unable to create record  #{e}"
  end

  def update
    InsightlyService::UserContact.new(user).update
    InsightlyService::UserOrganization.new(user).update
    InsightlyService::UserOpportunity.new(user).update
    InsightlyService::UserTask.new(user).perform
  rescue => e
    puts "insightly unable to update record  #{e}"
  end

  def contact_infos
    [{ type: "Email", label: "Work", detail: user.email },
     { type: "Phone", label: "Work", detail: user.business.phone
     }
    ]
  end

  def links_params
    contact_id = find_insightly_type_id('contact')
    organigasation_id = find_insightly_type_id('organisation')
    [{ contact_id: contact_id }, { organisation_id: organigasation_id }]
  end

  def find_insightly_type_id(type)
    insightly_repository.find_user_insightly(user, type).try(:type_id)
  end

  def inslightly_create(type, id, user_id = nil, name = nil)
    insightly_repository.find_or_create(insightly_type: type,
                                        type_id: id, name: name,
                                        user_id: user_id)
  end
end
