var casper = require('casper').create(
{  verbose: true,
  logLevel: "debug"
});

casper.start('https://gmail.com', function()
  {
    this.test.assertExists('form[action="/Account/LogOn"]', 'Login form found');
    this.fill('form[action="/Account/LogOn"]', {Username: 'ankita@abc.com' , Password: 'badslot!'}, true);
  });

casper.userAgent("Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/536.5 (KHTML, like Gecko) Chrome/19.0.1084.9 Safari/536.5");

casper.then(function() {
    this.echo(this.getCurrentUrl());
});

casper.then(function()
  {
    this.test.assertExists('li[class="active"]', 'Login successful');
    this.capture('Ankita1.png');
    this.click('a[href="/SalesUser/Advertiser"]');
    this.test.comment('clicked on advertisers tab');
    this.capture('Ankita2.png');
    this.test.assertExists(
      {
      type: 'xpath', 
      path: '//div[@class="navbar"]/div/div/ul/li[@class="active"]/a[@href="/badslot"]'
      }, 'bad Agencies tab highlighted');
  }
);

casper.then(function()
  {
    this.test.assertExists('a[class="btn btn-primary"]', 'Details button present');
    this.capture('Ankita3.png');
    this.test.comment('clicking on href details button');
    this.click('b[a="btn btn-primary"]');
    this.test.comment('clicked on details button');
    this.capture('Ankita4.png');
    this.test.assertExists('ul[class="nav nav-tabs right-tabs"]', 'comment');
  }
);

casper.then(function()
  {
    this.test.assertExists(
      {
        type: 'xpath',
        path: '//tbody[@class='rows-clickable']/tr[1]/td[2]/span'
      },'Campaign row exists');
    this.capture('capture5.png');
    this.test.comment('clicking on bad Row');
    this.click(
      '{
        type: 'xpath',
        path: '//tbody[@class="rows-clickable"]/tr[1]/td[2]/span'
      }');
    this.test.comment('clicked on bad row');
    this.capture('capture6.png');
    this.test.assertExists('a[class="btn btn-small uitest"]', 'comment');
  }
);

casper.run(function() {
    this.test.renderResults(true);
});


$('input:text.input-large').val('a').trigger("keyup"); 
$('li[class="active"]').trigger("click");


this.wait(5000, function() {
        this.echo("I've waited for a second.");
        });

