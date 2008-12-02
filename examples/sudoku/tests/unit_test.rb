require 'dancing_links_sudoku'

class DLinks
  
    def assert(statement)
      begin
        raise "Error on row #{$.} " unless statement
      rescue Exception => e
        raise "Error: #{e.backtrace}" 
      end
    end
    
    def verify_original(dla)
        testNode, prev = nil,nil
        column = dla.get_first_column;

        puts column.to_s
        assert(column != nil);
        assert(column.row_number() == 0);
        assert(column.label() == 1);
        assert(column.size() == 2);
        assert(column.down().verify_row_and_label(1, 1));
        assert(column.right().verify_row_and_label(0, 2));
        assert(column.left().verify_row_and_label(0, 0));
        assert(column.up().verify_row_and_label(4, 1));
        assert(column.column() == column);

        testNode = column.down();
        assert(testNode != nil);
        assert(testNode.row_number() == 1);
        assert(testNode.label() == 1);
        assert(testNode.left().verify_row_and_label(1, 2));
        assert(testNode.up() == column);
        assert(testNode.down().verify_row_and_label(4, 1));
        assert(testNode.column() == column);
        assert(testNode.right().verify_row_and_label(1, 2));

        prev = testNode;
        testNode = testNode.down();
        assert(testNode.up() == prev);
        assert(testNode.row_number() == 4);
        assert(testNode.label() == 1);
        assert(testNode.left().verify_row_and_label(4, 4));
        assert(testNode.down() == column);
        assert(testNode.column() == column);
        assert(testNode.right().verify_row_and_label(4, 4));

        column = column.right();

        assert(column != nil);
        assert(column.row_number() == 0);
        assert(column.label() == 2);
        assert(column.size() == 2);
        assert(column.left().verify_row_and_label(0, 1));
        assert(column.right().verify_row_and_label(0, 3));
        assert(column.down().verify_row_and_label(1, 2));
        assert(column.up().verify_row_and_label(2, 2));
        assert(column.column() == column);

        testNode = column.down();
        assert(testNode != nil);
        assert(testNode.row_number() == 1);
        assert(testNode.label() == 2);
        assert(testNode.left().verify_row_and_label(1, 1));
        assert(testNode.right().verify_row_and_label(1, 1));
        assert(testNode.up() == column);
        assert(testNode.column() == column);

        prev = testNode;
        testNode = testNode.down();
        assert(testNode.up() == prev);
        assert(testNode.row_number() == 2);
        assert(testNode.label() == 2);
        assert(testNode.left().verify_row_and_label(2, 4));
        assert(testNode.down() == column);
        assert(testNode.column() == column);
        assert(testNode.right().verify_row_and_label(2, 3));

        column = column.right();

        assert(column != nil);
        assert(column.row_number() == 0);
        assert(column.label() == 3);
        assert(column.size() == 2);
        assert(column.left().verify_row_and_label(0, 2));
        assert(column.right().verify_row_and_label(0, 4));
        assert(column.down().verify_row_and_label(2, 3));
        assert(column.up().verify_row_and_label(3, 3));
        assert(column.column() == column);

        testNode = column.down();
        assert(testNode != nil);
        assert(testNode.row_number() == 2);
        assert(testNode.label() == 3);
        assert(testNode.left().verify_row_and_label(2, 2));
        assert(testNode.right().verify_row_and_label(2, 4));
        assert(testNode.down().verify_row_and_label(3, 3));
        assert(testNode.up() == column);
        assert(testNode.column() == column);

        prev = testNode;
        testNode = testNode.down();
        assert(testNode.up() == prev);
        assert(testNode.row_number() == 3);
        assert(testNode.label() == 3);
        assert(testNode.left().verify_row_and_label(3, 4));
        assert(testNode.right().verify_row_and_label(3, 4));
        assert(testNode.down() == column);
        assert(testNode.up().verify_row_and_label(2, 3));
        assert(testNode.column() == column);

        column = column.right();

        assert(column != nil);
        assert(column.row_number() == 0);
        assert(column.label() == 4);
        assert(column.size() == 3);
        assert(column.left().verify_row_and_label(0, 3));
        assert(column.right().verify_row_and_label(0, 0));
        assert(column.down().verify_row_and_label(2, 4));
        assert(column.up().verify_row_and_label(4, 4));
        assert(column.column() == column);

        testNode = column.down();
        assert(testNode != nil);
        assert(testNode.row_number() == 2);
        assert(testNode.label() == 4);
        assert(testNode.left().verify_row_and_label(2, 3));
        assert(testNode.right().verify_row_and_label(2, 2));
        assert(testNode.down().verify_row_and_label(3, 4));
        assert(testNode.up() == column);
        assert(testNode.column() == column);

        prev = testNode;
        testNode = testNode.down();
        assert(testNode.up() == prev);
        assert(testNode.row_number() == 3);
        assert(testNode.label() == 4);
        assert(testNode.left().verify_row_and_label(3, 3));
        assert(testNode.right().verify_row_and_label(3, 3));
        assert(testNode.down().verify_row_and_label(4, 4));
        assert(testNode.up().verify_row_and_label(2, 4));
        assert(testNode.column() == column);

        prev = testNode;
        testNode = testNode.down();
        assert(testNode.up() == prev);
        assert(testNode.row_number() == 4);
        assert(testNode.label() == 4);
        assert(testNode.left().verify_row_and_label(4, 1));
        assert(testNode.right().verify_row_and_label(4, 1));
        assert(testNode.down() == column);
        assert(testNode.up().verify_row_and_label(3, 4));
        assert(testNode.column() == column);
    end

    def testit() 
        dla = nil
        labels = [1, 2, 3, 4];
        row1   = [1, 2];
        row2   = [2, 3, 4];
        row3   = [3, 4];
        row4   = [1, 4];
        columnNode, test = nil, nil

        dla = DancingLinksArena.new(labels);
        dla.add_initial_row(row1);
        dla.add_initial_row(row2);
        dla.add_initial_row(row3);
        dla.add_initial_row(row4);

        verify_original(dla);

        firstRow = dla.get_first_column().down();

        dla.remove_row(firstRow);
        columnNode = dla.get_first_column();
        assert(columnNode.size() == 1);
        assert(columnNode.row_number() == 0);
        assert(columnNode.label() == 3);
        assert(columnNode.left().verify_row_and_label(0, 0));
        assert(columnNode.right().verify_row_and_label(0, 4));
        assert(columnNode.down().verify_row_and_label(3, 3));
        assert(columnNode.up().verify_row_and_label(3, 3));

        assert(firstRow.verify_row_and_label(1, 1));
        assert(firstRow.left().verify_row_and_label(1, 2));
        assert(firstRow.right().verify_row_and_label(1, 2));
        assert(firstRow.down().verify_row_and_label(4, 1));
        assert(firstRow.up().verify_row_and_label(0, 1));

        dla.reinsert_row(firstRow);
        verify_original(dla);
    end

end

dl = DLinks.new();
dl.testit();
