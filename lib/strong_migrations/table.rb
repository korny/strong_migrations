module StrongMigrations
  module Table
    def column(*args)
      catch(:safe) do
        strong_migrations_checker.perform(:add_column, name, *args) do
          super
        end
      end
    end
    ruby2_keywords(:column) if respond_to?(:ruby2_keywords, true)

    def remove(*args)
      catch(:safe) do
        strong_migrations_checker.perform(:remove_columns, name, *args) do
          super
        end
      end
    end
    ruby2_keywords(:remove) if respond_to?(:ruby2_keywords, true)

    def safety_assured
      strong_migrations_checker.safety_assured do
        yield
      end
    end

    def stop!(message, header: "Custom check")
      raise StrongMigrations::UnsafeMigration, "\n=== #{header} #strong_migrations ===\n\n#{message}\n"
    end

    private

    def strong_migrations_checker
      StrongMigrations.current_migration.strong_migrations_checker
    end
  end
end
