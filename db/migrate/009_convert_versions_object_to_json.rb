class ConvertVersionsObjectToJson < ActiveRecord::Migration[5.1]
  def up
    add_column :versions, :new_object, :jsonb
    remove_column :versions, :object
    rename_column :versions, :new_object, :object
    add_column :versions, :object_changes, :jsonb
  end

  def down
    change_column :versions, :object, 'text USING object::text'
    remove_column :versions, :object_changes
  end

  private

  def convert_versions
    PaperTrail::Version.reset_column_information
    PaperTrail::Version.find_each do |version|
      next if version.object.blank?
      version.update_column :new_object, YAML.safe_load(version.object)
    end
  end
end
