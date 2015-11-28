# These constants are used with ThePirateBay and may change
# Every effort will be taken to ensure these are maintained.
# Written by @Netuoso

class Constants
  BASE_URL = 'https://thepiratebay.se'
  CATEGORIES = {
    all: '0',
    audio: {
      all: '100',
      music: '101',
      audio_books: '102',
      sound_clips: '103',
      flac: '104',
      other: '199'
    },
    video: {
      all: '200',
      movies: '201',
      movies_dvdr: '202',
      music_videos: '203',
      movie_clips: '204',
      tv_shows: '205',
      handheld: '206',
      hd_movies: '207',
      hd_tv_shows: '208',
      three_dimensions: '209',
      other: '299'
    },
    applications: {
      all: '300',
      windows: '301',
      mac: '302',
      unix: '303',
      handheld: '304',
      ios: '305',
      android: '306',
      other: '399'
    },
    games: {
      all: '400',
      pc: '401',
      mac: '402',
      psx: '403',
      xbox360: '404',
      wii: '405',
      handheld: '406',
      ios: '407',
      android: '408',
      other: '499'
    },
    porn: {
      all: '500',
      movies: '501',
      movies_dvdr: '502',
      pictures: '503',
      games: '504',
      hd_movies: '505',
      movie_clips: '506',
      other: '599'
    },
    other: {
      ebooks: '601',
      comics: '602',
      pictures: '603',
      covers: '604',
      physibles: '605',
      other: '699'
    }
  }

  ORDERING = {
    name: {
      des: '1',
      asc: '2'
    },
    uploaded: {
      des: '3',
      asc: '4'
    },
    size: {
      des: '5',
      asc: '6'
    },
    seeders: {
      des: '7',
      asc: '8'
    },
    leechers: {
      des: '9',
      asc: '10'
    },
    uploader: {
      des: '11',
      asc: '12'
    },
    type: {
      des: '13',
      asc: '14'
    }
  }

  # Set defaults if values not found
  ORDERING.default = '7'
  CATEGORIES.default = '0'
end
