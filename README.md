# UrlShortener

**Url shortener app made with Elixir and Plug**

## Installation

Run: `docker-compose up -d --build`

To create a link:
```
POST
http://localhost:9090/links

BODY:
{
	"url": "https://github.com/",
	"alias": "hi"
}
```

To go to a link:
```
GET
http://localhost:9090/:link_alias
EXAMPLE:
http://localhost:9090/hi
```

