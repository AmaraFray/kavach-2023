def scrape():
  import mysql.connector
  import feedparser

  config = {
    'user': 'your_username',
    'password': 'your_password',
    'host': 'your_host',
    'database': 'your_database'
  }
  cnx = mysql.connector.connect(**config)
  cursor = cnx.cursor()
  CREATE TABLE news (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    author VARCHAR(255),
    published_at DATETIME NOT NULL)
  
  
  


# Parse the RSS feed
  url = 'https://www.news18.com/rss/breaking-news.xml'
  feed = feedparser.parse(url)

# Extract data from the RSS feed
  for entry in feed.entries:
      title = entry.title
      description = entry.description
      author = entry.author
      published_at = entry.published


