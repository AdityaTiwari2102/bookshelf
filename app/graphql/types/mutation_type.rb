module Types
  class MutationType < Types::BaseObject

    # field :create_author, AuthorType, null: true, description: "Create an author" do
    #   argument :first_name, String, required: false, camelize: false
    #   argument :last_name, String, required: false, camelize: false
    #   argument :yob, Int, required: false, camelize: false
    #   argument :is_alive, Boolean, required: false, camelize: false
    # end
    #
    # def create_author(first_name:, last_name:, yob:, is_alive:)
    #   Author.create(first_name: first_name, last_name: last_name, yob: yob, is_alive: is_alive)
    # end

    field :create_author, Types::AuthorType, mutation: Mutations::CreateAuthor

    field :update_author, Boolean, null: false, description: "Update an author" do
      argument :author, Types::AuthorInputType, required: true
    end

    def update_author(author:)
      existing = Author.where(id: author[:id]).first
      existing&.update(author.to_h)
    end

    field :delete_author, String, null: false, description: "Delete an author" do
      argument :id, ID, required: true
    end

    def delete_author(id:)
      author = Author.where(id: id)
      if author.present?
        author.destroy_all
        "Author with id:#{id} is deleted."
      else
        "Could not find the author with id:#{id}."
      end
    end
  end
end
