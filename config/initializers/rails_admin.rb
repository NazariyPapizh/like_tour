RailsAdmin.config do |config|

  ### Popular gems integration

  ## == Devise ==
  config.authenticate_with do
    warden.authenticate! scope: :user
  end
  config.current_user_method(&:current_user)

  ## == Cancan ==
  config.authorize_with :cancan

  ## == PaperTrail ==
  config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app

    # multi
    # multiple_upload

    ## With an audit adapter, you can add:
    # history_index
    # history_show
    # Add the nestable action for configured models
    nestable
  end
  included_models = [ User, Category, Tour, PhotoGallery, City, FilterWord, WorkRegion, Publication, BrandCarousel, About, Personnel, IndexBanner, ContactsInfo, Service, Regulations, FeedBack, Certificate]

  included_models.each do |model|


    model_class = model
    if model_class.is_a?(String)# && Object.const_defined?(model_class)
      model_class = Object.const_get(model_class)
    end

    if ActiveRecord::Base.connection.tables.include?(model_class.table_name)

      config.included_models += [model_class]
      if model_class.respond_to?(:translates) && model_class.translates? && ActiveRecord::Base.connection.tables.include?(model_class.translation_class.table_name)
        config.included_models += [model_class.translation_class]
      end
    end
  end
end
