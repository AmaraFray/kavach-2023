def scrape():
  import feedparser
  article_data=[]
# Parse the RSS feed
  url1 = 'https://www.news18.com/rss/breaking-news.xml'
  url2='https://timesofindia.indiatimes.com/rssfeeds/-2128936835.cms'
  url3='https://timesofindia.indiatimes.com/rssfeedmostrecent.cms'
  url4='https://economictimes.indiatimes.com/rssfeedsdefault.cms'
  feed1 = feedparser.parse(url1)
  feed2 = feedparser.parse(url2)
  feed3 = feedparser.parse(url3)
  feed4 = feedparser.parse(url4)
  for j in [feed1,feed2,feed3,feed4]:
    for entry in j.entries:
      data={}
      words=    ['crime','murder','rape','harm','danger','knife','killer','kill','shoot','shot','suicide','depression']
      for i in words:
        if i.lower()+" " in entry.description.lower():
          data["title"] = entry.title
          data["description"] = entry.description
 #   data["author"] = entry.author
          data["published_at"] = entry.published
        
          article_data.append(data)
  return article_data
      


