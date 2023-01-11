## What is a Live Session

- Reuse code between multiple Live Views
- We can intercept events on your views
- Set default layouts and session keys
- The most common use case is auth

## Show me the functions

- [live_session/3 (macro)](https://hexdocs.pm/phoenix_live_view/Phoenix.LiveView.Router.html#live_session/3)
- [on_mount/1 (macro)](https://hexdocs.pm/phoenix_live_view/Phoenix.LiveView.html#on_mount/1)
- [attach_hook/4](https://hexdocs.pm/phoenix_live_view/Phoenix.LiveView.html#attach_hook/4)
- [detach_hook/4](https://hexdocs.pm/phoenix_live_view/Phoenix.LiveView.html#detach_hook/3)

## Let's build an ~~useless~~ Live Session!

- We want to log users joining on certain pages and events they do
- We have a simple page for that: [PageLive](lib/session_playground_web/live/page_live.ex#L1)

## phx.gen.auth

```sh
$ mix phx.gen.auth Accounts User users
$ mix deps.get
$ mix ecto.migrate
```

- [:redirect_if_user_is_authenticated](lib/session_playground_web/router.ex#L53)
- [:require_authenticated_user](lib/session_playground_web/router.ex#L67)
- [:current_user](lib/session_playground_web/router.ex#L79)

## Meet the Nav LiveSession

- We created a simple Live Session to assign `:active_nav` for our layout called [Nav](lib/session_playground_web/live/nav.ex#L1)
- The [<.light_nav>](lib/session_playground_web/components/core_components.ex#619) component handles the value and apply the styles
- We use that component on our [app.html.heex](lib/session_playground_web/components/layouts/app.html.heex#L1) template passing

## How navigating between Live Sessions work?

- If it's in the same Live Session Phoenix will reuse the connection
- If it's between sessions a full page load will trigger

## Reuse code with LiveSessions

- We have a LiveView ready for notifications called [NotificationsLive](lib/session_playground_web/live/notification_live.ex#L1)
- We created a simple [<.notifications>](lib/session_playground_web/components/core_components.ex#L128) component as a core_component and applied it on our [app template](lib/session_playground_web/components/layouts/app.html.heex#L63).
- Let's make this a Live Session we can reuse
