"""A Selenium bot to buy sneakers off Adidas's Website (03/10/18)."""
from selenium import webdriver

# PRODUCT_URL = 'https://www.adidas.com/us' +\
#     '/pharrell-williams-hu-holi-nmd-mc-shoes/AC7034.html'
PRODUCT_URL = 'https://www.adidas.com/us' +\
    '/ultraboost-uncaged-shoes/DA9164.html'

driver = webdriver.Firefox()
driver.get(PRODUCT_URL)
driver.execute_script('''
    document.querySelector('div[data-auto-id="size-selector"] div.custom-input').click();
    document.querySelector('div[data-auto-id="size-selector"] li[title="11.5"]').click();
    document.querySelector('button[type="submit"]').click();
''')
