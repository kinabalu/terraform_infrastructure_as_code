from apistar.frameworks.wsgi import WSGIApp as App
from apistar import Include, Route, Response


def welcome_j2d() -> Response:
    # TODO find the translation and write a funny saying re: Bulgaria and Rakia
    return Response({"message":"How much Rakia can one drink"}, status=200)

def health_check() -> Response:
    return Response({"status": "OK"}, status=200)


routes = [
    Route('/health', 'GET', health_check),
    Route('/', 'GET', welcome_j2d),
]

app = App(
    routes=routes,
)
