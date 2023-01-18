class ChangeTableAddColumnDefault < TestMigration
  def change
    change_table :users do |t|
      t.boolean :nice, default: true
    end
  end
end

class ChangeTableAddColumnDefaultSafe < TestMigration
  def change
    change_table :users do |t|
      t.boolean :nice
      t.change_default :nice, from: true, to: false
    end
  end
end


class ChangeTableRemoveColumns < TestMigration
  def up
    change_table :users do |t|
      t.remove :name
    end
  end
end
