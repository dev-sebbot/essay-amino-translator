#!/usr/bin/env python
import sys
import requests
import AdvancedHTMLParser


USAGE = """python scraper.py <option>
  scores id-start id-end output_dir
  matchkda id-start id-end output_dir"""

def get_scores(id):
  result = requests.get("https://www.thespike.gg/events/results/"+id)

  if result.status_code == 200:
    scores = []
    parser = AdvancedHTMLParser.AdvancedHTMLParser()
    parser.parseStr(result.content)

    matches = parser.getElementsByClassName("single-match element-trim-button main-colour-background")
    urls = matches.getElementsByTagName("a")

    for url in urls:
      try:
        pair = url.getElementsByClassName("inner-scores")
        winner = pair.getElementsByClassName("result winner")[0].innerHTML
        loser = pair.getElementsByClassName("result loser")[0].innerHTML
        scores.append((winner, loser, url.href))
      except Exception:
        pass
    return scores
  else:
    return None


def get_score_range(id_start, id_end, output_directory):
  id_start = int(id_start)
  id_end = int(id_end)

  if id_end - id_start > 1:
    decision = input("You're requesting more than once. Are you sure? (y/n) ")
    if decision != "y":
      sys.exit()

  for id in range(id_start, id_end+1):
    id = str(id)
    scores = get_scores(id)

    if scores != None:
      f = open("./" + output_directory + "/" + id + ".csv", "w")
      for score in scores:
        f.write(score[0] + "," + score[1] + "," + score[2] + "\n")
      f.close()


# Accepts urls of the form "https://www.thespike.gg/match/tag/matchid"
def get_match_kda(url, winner_num, loser_num):
  result = requests.get("https://www.thespike.gg"+url+"?map=all-maps&tab=performance")
  print(url)

  if result.status_code == 200:
    parser = AdvancedHTMLParser.AdvancedHTMLParser()
    parser.parseStr(result.content)

    try:
      winner = parser.getElementsByClassName("performance-overview-stat team-" + winner_num)[0].innerHTML
      loser = parser.getElementsByClassName("performance-overview-stat team-" + loser_num)[0].innerHTML
      winner_assist = parser.getElementsByClassName("performance-overview-stat team-" + winner_num)[2].innerHTML
      loser_assist = parser.getElementsByClassName("performance-overview-stat team-" + loser_num)[2].innerHTML
    except Exception:
      return None

    return (url, winner, loser, winner_assist, loser_assist)
  else:
    return None


def get_match_kdas_from_event(id):
  result = requests.get("https://www.thespike.gg/events/results/"+id)
  print(id)

  if result.status_code == 200:
    parser = AdvancedHTMLParser.AdvancedHTMLParser()
    parser.parseStr(result.content)

    match_list = parser.getElementsByClassName("matches-overview-list")    
    matches = match_list.getElementsByClassName("single-match element-trim-button main-colour-background")
    urls = matches.getElementsByTagName("a")

    kds = []
    for url in urls:
      inner_scores = url.getElementsByClassName("inner-scores")[0].getChildren()

      kd = None
      if(inner_scores[0].classNames == ["result", "winner"]):
        kd = get_match_kda(url.href, "1", "2")
      else:
        kd = get_match_kda(url.href, "2", "1")
      
      if kd != None:
        kds.append(kd)
    return kds
  else:
    return None


def get_match_kdas_from_event_range(id_start, id_end, output_directory):
  id_start = int(id_start)
  id_end = int(id_end)

  if id_end - id_start > 1:
    decision = input("You're RECURSIVELY requesting more than once. Are you sure? (y/n) ")
    if decision != "y":
      sys.exit()

  for id in range(id_start, id_end+1):
    id = str(id)
    kds = get_match_kdas_from_event(id)

    if kds != None:
      f = open("./" + output_directory + "/" + id + ".csv", "w")
      for kd in kds:
        f.write(kd[0] + "," + kd[1] + "," + kd[2] + "," + kd[3] + "," + kd[4] + "\n")
      f.close()


if __name__ == '__main__':
  if(len(sys.argv) == 1):
    print(USAGE)
    sys.exit()
  if(sys.argv[1] == "scores") and len(sys.argv) == 5:
    get_score_range(sys.argv[2], sys.argv[3], sys.argv[4])
  elif(sys.argv[1] == "matchkda") and len(sys.argv) == 5:
    get_match_kdas_from_event_range(sys.argv[2], sys.argv[3], sys.argv[4])
  else:
    print(USAGE)
    sys.exit()