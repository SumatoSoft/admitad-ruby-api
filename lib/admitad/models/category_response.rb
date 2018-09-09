module Admitad
  class Category < Success
    attribute :id, Integer
    attribute :parent, Category
    attribute :name, String
    attribute :language, String
  end

  class CategoryResponse < Success
    attribute :results, Array[Category]
    attribute :_meta, Hash

    alias categories results
    alias metadata _meta
  end
end
