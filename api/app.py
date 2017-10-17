from apistar.frameworks.wsgi import WSGIApp as App
from apistar import Include, Route, Response


def welcome_j2d() -> Response:
    return Response({"message":u"Андрю наистина харесва ракия"}, status=200)

def health_check() -> Response:
    return Response({"status": "OK"}, status=200)


routes = [
    Route('/health', 'GET', health_check),
    Route('/', 'GET', welcome_j2d),
]

app = App(
    routes=routes,
)
