require 'pathname'

module FasterPath
  module MonkeyPatches
    def self._ruby_core_file!
      ::File.class_eval do
        def self.basename(pth, ext = '')
          FasterPath.basename(pth, ext)
        end

        def self.extname(pth)
          FasterPath.extname(pth)
        end

        def self.dirname(pth)
          FasterPath.dirname(pth)
        end
      end if ENV['WITH_REGRESSION']
    end

    def self._ruby_library_pathname!
      ::Pathname.class_eval do
        def absolute?
          FasterPath.absolute?(@path)
        end

        def directory?
          FasterPath.directory?(@path)
        end

        def chop_basename(pth)
          FasterPath.chop_basename(pth)
        end
        private :chop_basename

        def relative?
          FasterPath.relative?(@path)
        end

        def add_trailing_separator(pth)
          FasterPath.add_trailing_separator(pth)
        end
        private :add_trailing_separator

        def has_trailing_separator?(pth)
          FasterPath.has_trailing_separator?(pth)
        end
        private :has_trailing_separator?

        def entries
          FasterPath.entries(@path)
        end
      end
    end
  end
  private_constant :MonkeyPatches

  def self.sledgehammer_everything!
    MonkeyPatches._ruby_core_file!
    MonkeyPatches._ruby_library_pathname!
    "CAUTION: Monkey patching effects everything! Be very sure you want this!"
  end
end
