local async = require("plenary.async.tests")
local plugin = require("neotest-go")
local lib = require("neotest.lib")
local assert = require("luassert")
local say = require("say")

local function create_tree(positions)
  return Tree.from_list(positions, function(pos)
    return pos.id
  end)
end

local function has_property(state, arguments)
  local property = arguments[1]
  local table = arguments[2]
  for key, value in pairs(table) do
    if key == property then
      return true
    end
  end
  return false
end

say:set_namespace("en")
say:set("assertion.has_property.positive", "Expected property %s in:\n%s")
say:set("assertion.has_property.negative", "Expected property %s to not be in:\n%s")
assert:register(
  "assertion",
  "has_property",
  has_property,
  "assertion.has_property.positive",
  "assertion.has_property.negative"
)

describe("is_test_file", function()
  it("matches Go files", function()
    assert.equals(true, plugin.is_test_file("foo_test.go"))
  end)
end)

describe("discover_positions", function()
  async.it("discovers positions in unit tests in many_table_test.go", function()
    local path = vim.loop.cwd() .. "/neotest_go/many_table_test.go"
    local positions = plugin.discover_positions(path):to_list()

    local expected_positions = {
      {
        id = vim.loop.cwd() .. "/neotest_go/many_table_test.go",
        name = "many_table_test.go",
        path = vim.loop.cwd() .. "/neotest_go/many_table_test.go",
        range = { 0, 0, 32, 0 },
        type = "file",
      },
      {
        {
          id = vim.loop.cwd() .. "/neotest_go/many_table_test.go::TestSomeTest",
          name = "TestSomeTest",
          path = vim.loop.cwd() .. "/neotest_go/many_table_test.go",
          range = { 8, 0, 31, 1 },
          type = "test",
        },
        {
          {
            id = vim.loop.cwd() .. "/neotest_go/many_table_test.go::TestSomeTest::AccessDenied1",
            name = '"AccessDenied1"',
            path = vim.loop.cwd() .. "/neotest_go/many_table_test.go",
            range = { 16, 2, 16, 118 },
            type = "test",
          },
        },
        {
          {
            id = vim.loop.cwd() .. "/neotest_go/many_table_test.go::TestSomeTest::AccessDenied2",
            name = '"AccessDenied2"',
            path = vim.loop.cwd() .. "/neotest_go/many_table_test.go",
            range = { 17, 2, 17, 118 },
            type = "test",
          },
        },
        {
          {
            id = vim.loop.cwd() .. "/neotest_go/many_table_test.go::TestSomeTest::AccessDenied3",
            name = '"AccessDenied3"',
            path = vim.loop.cwd() .. "/neotest_go/many_table_test.go",
            range = { 18, 2, 18, 118 },
            type = "test",
          },
        },
        {
          {
            id = vim.loop.cwd() .. "/neotest_go/many_table_test.go::TestSomeTest::AccessDenied4",
            name = '"AccessDenied4"',
            path = vim.loop.cwd() .. "/neotest_go/many_table_test.go",
            range = { 19, 2, 19, 118 },
            type = "test",
          },
        },
        {
          {
            id = vim.loop.cwd() .. "/neotest_go/many_table_test.go::TestSomeTest::AccessDenied5",
            name = '"AccessDenied5"',
            path = vim.loop.cwd() .. "/neotest_go/many_table_test.go",
            range = { 20, 2, 20, 118 },
            type = "test",
          },
        },
        {
          {
            id = vim.loop.cwd() .. "/neotest_go/many_table_test.go::TestSomeTest::AccessDenied6",
            name = '"AccessDenied6"',
            path = vim.loop.cwd() .. "/neotest_go/many_table_test.go",
            range = { 21, 2, 21, 118 },
            type = "test",
          },
        },
      },
    }
    assert.are.same(positions, expected_positions)
  end)
  async.it("discovers positions in unit tests in cases_test.go", function()
    local path = vim.loop.cwd() .. "/neotest_go/cases_test.go"
    local positions = plugin.discover_positions(path):to_list()
    local expected_positions = {
      {
        id = vim.loop.cwd() .. "/neotest_go/cases_test.go",
        name = "cases_test.go",
        path = vim.loop.cwd() .. "/neotest_go/cases_test.go",
        range = { 0, 0, 49, 0 },
        type = "file",
      },
      {
        {
          id = vim.loop.cwd() .. "/neotest_go/cases_test.go::TestSubtract",
          name = "TestSubtract",
          path = vim.loop.cwd() .. "/neotest_go/cases_test.go",
          range = { 8, 0, 33, 1 },
          type = "test",
        },
        {
          {
            id = vim.loop.cwd() .. "/neotest_go/cases_test.go::TestSubtract::test_one",
            name = '"test one"',
            path = vim.loop.cwd() .. "/neotest_go/cases_test.go",
            range = { 15, 2, 20, 3 },
            type = "test",
          },
        },
        {
          {
            id = vim.loop.cwd() .. "/neotest_go/cases_test.go::TestSubtract::test_two",
            name = '"test two"',
            path = vim.loop.cwd() .. "/neotest_go/cases_test.go",
            range = { 21, 2, 26, 3 },
            type = "test",
          },
        },
      },
      {
        {
          id = vim.loop.cwd() .. "/neotest_go/cases_test.go::TestAdd",
          name = "TestAdd",
          path = vim.loop.cwd() .. "/neotest_go/cases_test.go",
          range = { 35, 0, 48, 1 },
          type = "test",
        },
        {
          {
            id = vim.loop.cwd() .. "/neotest_go/cases_test.go::TestAdd::test_one",
            name = '"test one"',
            path = vim.loop.cwd() .. "/neotest_go/cases_test.go",
            range = { 36, 1, 38, 3 },
            type = "test",
          },
        },
        {
          {
            id = vim.loop.cwd() .. "/neotest_go/cases_test.go::TestAdd::test_two",
            name = '"test two"',
            path = vim.loop.cwd() .. "/neotest_go/cases_test.go",
            range = { 40, 1, 42, 3 },
            type = "test",
          },
        },
      },
    }

    assert.are.same(positions, expected_positions)
  end)
end)

describe("prepare_results", function()
  async.it(
    "check that we have file level test result as well as all nested results in cases_test.go",
    function()
      local tests_folder = vim.loop.cwd() .. "/neotest_go/"
      local test_file = tests_folder .. "cases_test.go"
      local positions = plugin.discover_positions(test_file)

      local expected_keys = {
        test_file,
        test_file .. "::TestAdd",
        test_file .. "::TestAdd::test_one",
        test_file .. "::TestAdd::test_two",
        test_file .. "::TestSubtract",
        test_file .. "::TestSubtract::test_one",
        test_file .. "::TestSubtract::test_two",
      }
      -- we should run test from module root
      local command = {
        "cd",
        tests_folder,
        "&&",
        "go",
        "test",
        "-v",
        "-json",
        "",
        "-count=1",
        "-timeout=60s",
        "./...",
      }
      local handle = io.popen(table.concat(command, " "))
      local result = handle:read("*a")
      handle:close()

      local lines = {}
      for s in result:gmatch("[^\r\n]+") do
        table.insert(lines, s)
      end
      local processed_results =
        plugin.prepare_results(positions, lines, tests_folder .. "...", "neotest_go")

      for _, v in pairs(expected_keys) do
        assert.has_property(v, processed_results)
      end
    end
  )
end)
