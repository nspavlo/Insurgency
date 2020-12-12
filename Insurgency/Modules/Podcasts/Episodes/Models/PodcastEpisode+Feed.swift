//
//  PodcastEpisode+Feed.swift
//  Insurgency
//
//  Created by Jans Pavlovs on 09/12/2020.
//

import FeedKit
import Foundation

// MARK: RSSFeedItem

extension PodcastEpisode {
    init?(_ rss: RSSFeedItem) {
        if let title = rss.iTunes?.iTunesTitle {
            self.title = title
        } else {
            return nil
        }

        if let subtitle = rss.iTunes?.iTunesSubtitle {
            self.subtitle = subtitle
        } else {
            return nil
        }

        if let date = rss.pubDate {
            self.date = date
        } else {
            return nil
        }

        if let string = rss.iTunes?.iTunesImage?.attributes?.href,
           let image = URL(string: string)
        {
            self.image = image
        } else {
            return nil
        }

        if let string = rss.enclosure?.attributes?.url,
           let stream = URL(string: string)
        {
            self.stream = stream
        } else {
            return nil
        }
    }
}
