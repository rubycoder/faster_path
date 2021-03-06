require "benchmark_helper"

class BasenameBenchmark < BenchmarkHelper

  def setup
    @file ||= __FILE__
  end

  def teardown
    super
    graph_benchmarks
  end

  def bench_rust_basename
    benchmark_graph :rust do
      FasterPath.basename("/hello/world")
      FasterPath.basename('/home/gumby/work/ruby.rb', '.rb')
      FasterPath.basename('/home/gumby/work/ruby.rb', '.*')
    end
  end

  def bench_ruby_basename
    benchmark_graph :ruby do
      File.basename("/hello/world")
      File.basename('/home/gumby/work/ruby.rb', '.rb')
      File.basename('/home/gumby/work/ruby.rb', '.*')
    end
  end
end
