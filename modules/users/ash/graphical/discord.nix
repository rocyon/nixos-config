{
  __findFile,
  inputs,
  ...
}: {
  flake-file.inputs = {
    nixcord = {
      url = "github:FlameFlag/nixcord";
    };
  };

  den.aspects.ash._.graphical._.discord = {
    homeManager = {
      osConfig,
      config,
      pkgs,
      ...
    }: {
      homeManager = {...}: {
        imports = [inputs.nixcord.homeModules.nixcord];

        stylix.targets.nixcord.enable = true;

        programs.nixcord = {
          enable = true;

          # package = pkgs.discord-ptb;

          # explicitly disable vesktop
          discord.vencord.enable = false;
          vesktop.enable = false;

          discord.equicord.enable = false; # seems to fail occasionally?

          dorion = {
            enable = true;
            clientMods = ["Shelter" "Equicord"];
          };

          equibop.enable = true;

          config = {
            transparent = true;

            # I dispise the capitalization, but that's what it is
            # https://flameflag.github.io/nixcord/
            plugins = {
              ClearURLs.enable = true;
              CopyUserURLs.enable = true;
              IRememberYou.enable = true;
              MutualGroupDMs.enable = true;
              PinDMs.enable = true;
              USRBG.enable = true;
              UserPFP.enable = true;
              accountPanelServerProfile.enable = true;
              allCallTimers.enable = true;
              alwaysExpandProfiles.enable = true;
              anonymiseFileNames.enable = true;
              autoZipper.enable = true;
              betterAudioPlayer.enable = true;
              betterFolders.enable = true;
              betterFolders.sidebar = true;
              betterInvites.enable = true;
              bypassStatus.enable = true;
              callTimer.enable = true;
              cleanChannelName.enable = true;
              cleanUserArea.enable = true;
              copyFileContents.enable = true;
              copyStickerLinks.enable = true;
              decor.enable = true;
              dontFilterMe.enable = true;
              dontRoundMyTimestamps.enable = true;
              expressionCloner.enable = true;
              fakeNitro.enable = true;
              favoriteEmojiFirst.enable = true;
              favoriteGifSearch.enable = true;
              findReply.enable = true;
              fixCodeblockGap.enable = true;
              fixImagesQuality.enable = true;
              fixYoutubeEmbeds.enable = true;
              forceOwnerCrown.enable = true;
              forwardAnywhere.enable = true;
              friendsSince.enable = true;
              gameActivityToggle.enable = true;
              gifPaste.enable = true;
              googleThat.enable = true;
              guildTagSettings.enable = true;
              homeTyping.enable = true;
              iLoveSpam.enable = true;
              imageZoom.enable = true;
              imgToGif.enable = true;
              implicitRelationships.enable = true;
              ircColors.applyColorOnlyToUsersWithoutColor = true;
              ircColors.enable = true;
              #keyboardNavigation.enable = true;
              messageBurst.enable = true; # Interesting
              voiceChatDoubleClick.enable = true;
              # messageLogger.collapseDeleted = true;
              # messageLogger.enable = true;
              # messageLogger.ignoreBots = true;
              # messageLogger.separatedeDiffs = true;
              # messageLogger.showEditDiffs = true;
              messageLoggerEnhanced.enable = true;
              moreStickers.enable = true;
              noF1.enable = true;
              noModalAnimation.enable = true;
              noReplyMention.enable = true;
              #orbolayBridge.enable = true; # TODO
              pauseInvitesForever.enable = true;
              permissionFreeWill.enable = true;
              permissionsViewer.enable = true;
              petpet.enable = true;
              pinIcon.enable = true;
              platformIndicators.enable = true;
              platformSpoofer.enable = true;
              platformSpoofer.platform = "desktop";
              previewMessage.enable = true;
              questCompleter.enable = true;
              #quickThemeSwitcher.enable = true; # TODO
              relationshipNotifier.enable = true;
              revealAllSpoilers.enable = true;
              roleColorEverywhere.enable = true;
              sendTimestamps.enable = true;
              shikiCodeblocks.enable = true;
              showHiddenChannels.enable = true;
              showHiddenThings.enable = true;
              showTimeoutDuration.enable = true;
              sidebarChat.enable = true;
              silentMessageToggle.enable = true;
              silentTyping.enable = true;
              soundBoardLogger.enable = true;
              splitLargeMessages.enable = true;
              stickerPaste.enable = true;
              timezones._24hTime = true;
              timezones.enable = true;
              toneIndicators.enable = true;
              typingIndicator.enable = true;
              typingTweaks.enable = true;
              unindent.enable = true;
              unsuppressEmbeds.enable = true;
              voiceChatUtilities.enable = true;
              voiceDownload.enable = true;
              volumeBooster.enable = true;
              youtubeAdblock.enable = true;
            }; #plugins
          }; #config
        };
      }; #homeManager
    };
  };
}
