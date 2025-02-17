-- better support for csv/tsv file fortmats
return {
    'hat0uma/csvview.nvim',
    ft = {"tsv", "csv"},
    cmd = {"CsvViewEnable", "CsvViewDisable", "CsvViewToggle"},
    config = function()
        require('csvview').setup()
    end
}
