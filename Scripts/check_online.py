#!/usr/bin/env python3
"""
Script for getting online followed channels for a given user
A `CLIENT_ID` can either be generated, or a random one gotten
by merely visiting Twitch and inspecting the network requests.
"""
from urllib.request import urlopen
import json
import sys

CLIENT_ID = "kimne78kx3ncx6brgo4mv6wki5h1ko"

def get_following(user):
    """Return list of channels followed by given user"""
    base = "https://api.twitch.tv/kraken/users/%s/follows/channels?limit=100&client_id=%s"
    url = base % (user, CLIENT_ID)
    info = json.loads(urlopen(url, timeout=15).read().decode('utf-8'))
    return list(map(lambda s: s["channel"]["name"], info["follows"]))


def is_online(users):
    """Return list of users out of given that are online"""
    base = "https://api.twitch.tv/kraken/streams/?channel=%s&client_id=%s"
    url = base % (",".join(users), CLIENT_ID)
    info = json.loads(urlopen(url, timeout=15).read().decode('utf-8'))
    return list(map(lambda s: s["channel"]["name"], info["streams"]))

if __name__ == '__main__':
    followed = get_following(sys.argv[1])
    print("\n".join(is_online(followed)))
