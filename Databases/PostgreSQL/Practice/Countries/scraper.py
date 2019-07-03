import requests
from bs4 import BeautifulSoup as bs

html = requests.get('https://en.wikipedia.org/wiki/List_of_sovereign_states').content
soup = bs(html, 'lxml')
rows = soup.select('table')

print rows
