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
        if let title = rss.iTunes?.iTunesTitle ?? rss.title {
            self.title = title
        } else {
            return nil
        }

        if let subtitle = rss.iTunes?.iTunesSubtitle ?? rss.iTunes?.iTunesSummary {
            // Some podcasts will have html tags in description
            self.subtitle = subtitle.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression)
        } else {
            self.subtitle = ""
        }

        if let date = rss.pubDate {
            self.date = date
        } else {
            return nil
        }

        if let string = rss.iTunes?.iTunesImage?.attributes?.href {
            self.artworkURL = URL(string: string)
        } else {
            self.artworkURL = nil
        }

        if let string = rss.enclosure?.attributes?.url,
           let url = URL(string: string)
        {
            self.mediaURL = url
        } else {
            return nil
        }
    }
}
