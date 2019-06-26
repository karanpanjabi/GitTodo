# git_todo

An app made in flutter for tracking TODOs in git repositories. Gotta finish your work, people!

* Track repositories or specific files within a respository.
* Put RemindMe bot (reddit bot) like comments to get notified about your pending work at some point in future.
* Edit TODOs straight from the app.

## Usage

Install the app, login, and start tracking away your repos or files.

Use @TODO \<comment> or @TODO [timestamp or time-phrase] \<comment>

Examples:

In python
```python

def func():
    # @TODO implement this
    # @TODO [2 days] implement this
    pass

if __name__ == "__main__":
    func()
```


## Contributing

Contributions are welcome, but as of right now I've barely started building the app itself. All suggestions are welcome as well.

## Development progress/notes

* Github OAuth login and firebase deep linking (to be started)
* Models for tracking repositories + files
* Implement time-phrase system from RemindMe bot from [reddit](https://www.reddit.com/r/RemindMeBot/comments/c5l9ie/remindmebot_info_v20/).
