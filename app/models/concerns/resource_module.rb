module ResourceModule
  extend ActiveSupport::Concern

  included do
    after_commit :setup_manage_storage, on: [:create, :update]
    after_commit :destroy_manage_storage, on: [:destroy]
  end

  def setup_manage_storage
    self.class.reflect_on_all_associations(:belongs_to).each do |association|
      if association.options[:class_name] == 'ManageStorage' and self.previous_changes[association.name.to_s + '_id']
        previous_id = self.previous_changes[association.name.to_s + '_id'][0]
        current_id = self.previous_changes[association.name.to_s + '_id'][1]

        ManageStorage.find(previous_id).destroy if previous_id
        ManageStorage.find(current_id).update(source: self) if current_id
      end
    end
  end

  def destroy_manage_storage
    self.class.reflect_on_all_associations(:belongs_to).each do |association|
      if association.options[:class_name] == 'ManageStorage'
        current_id = self[association.name.to_s + '_id']
        ManageStorage.find(current_id).destroy if current_id
      end
    end
  end
end