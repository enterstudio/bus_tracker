require "open-uri"

class JSONFetcher
  def hash_for_url(url)
    JSON.parse(open(url).read)
  end
end
