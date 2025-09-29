module ApplicationHelper
  def star_rating(rating, size = 'medium')
    size_classes = {
      'small' => 'w-4 h-4',
      'medium' => 'w-5 h-5',
      'large' => 'w-8 h-8'
    }

    stars_html = (1..5).map do |star|
      if rating >= star
        # Estrela completamente preenchida
        "<svg class=\"#{size_classes[size]} text-yellow-400\" aria-hidden=\"true\" xmlns=\"http://www.w3.org/2000/svg\" fill=\"currentColor\" viewBox=\"0 0 22 20\">
          <path d=\"M20.924 7.625a1.523 1.523 0 0 0-1.238-1.044l-5.051-.734-2.259-4.577a1.534 1.534 0 0 0-2.752 0L7.365 5.847l-5.051.734A1.535 1.535 0 0 0 1.463 9.2l3.656 3.563-.863 5.031a1.532 1.532 0 0 0 2.226 1.616L11 17.033l4.518 2.375a1.534 1.534 0 0 0 2.226-1.617l-.863-5.03L20.537 9.2a1.523 1.523 0 0 0 .387-1.575Z\"/>
        </svg>"
      elsif rating > star - 1
        # Estrela parcialmente preenchida
        partial_width = (rating - (star - 1)) * 100
        "<div class=\"relative #{size_classes[size]} inline-block\">
          <svg class=\"#{size_classes[size]} text-gray-300 absolute inset-0\" aria-hidden=\"true\" xmlns=\"http://www.w3.org/2000/svg\" fill=\"currentColor\" viewBox=\"0 0 22 20\">
            <path d=\"M20.924 7.625a1.523 1.523 0 0 0-1.238-1.044l-5.051-.734-2.259-4.577a1.534 1.534 0 0 0-2.752 0L7.365 5.847l-5.051.734A1.535 1.535 0 0 0 1.463 9.2l3.656 3.563-.863 5.031a1.532 1.532 0 0 0 2.226 1.616L11 17.033l4.518 2.375a1.534 1.534 0 0 0 2.226-1.617l-.863-5.03L20.537 9.2a1.523 1.523 0 0 0 .387-1.575Z\"/>
          </svg>
          <div class=\"absolute inset-0 overflow-hidden\" style=\"width: #{partial_width}%\">
            <svg class=\"#{size_classes[size]} text-yellow-400\" aria-hidden=\"true\" xmlns=\"http://www.w3.org/2000/svg\" fill=\"currentColor\" viewBox=\"0 0 22 20\">
              <path d=\"M20.924 7.625a1.523 1.523 0 0 0-1.238-1.044l-5.051-.734-2.259-4.577a1.534 1.534 0 0 0-2.752 0L7.365 5.847l-5.051.734A1.535 1.535 0 0 0 1.463 9.2l3.656 3.563-.863 5.031a1.532 1.532 0 0 0 2.226 1.616L11 17.033l4.518 2.375a1.534 1.534 0 0 0 2.226-1.617l-.863-5.03L20.537 9.2a1.523 1.523 0 0 0 .387-1.575Z\"/>
            </svg>
          </div>
        </div>"
      else
        # Estrela vazia
        "<svg class=\"#{size_classes[size]} text-gray-300\" aria-hidden=\"true\" xmlns=\"http://www.w3.org/2000/svg\" fill=\"currentColor\" viewBox=\"0 0 22 20\">
          <path d=\"M20.924 7.625a1.523 1.523 0 0 0-1.238-1.044l-5.051-.734-2.259-4.577a1.534 1.534 0 0 0-2.752 0L7.365 5.847l-5.051.734A1.535 1.535 0 0 0 1.463 9.2l3.656 3.563-.863 5.031a1.532 1.532 0 0 0 2.226 1.616L11 17.033l4.518 2.375a1.534 1.534 0 0 0 2.226-1.617l-.863-5.03L20.537 9.2a1.523 1.523 0 0 0 .387-1.575Z\"/>
        </svg>"
      end
    end.join

    "<div class=\"flex items-center space-x-1\">#{stars_html}</div>".html_safe
  end
end
